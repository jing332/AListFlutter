#include <jni.h>
#include <string>

#include <stdio.h>
#include <stdlib.h>
#include <arpa/inet.h>
#include <string.h>
#include <sys/ioctl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <unistd.h>

#define RUN_SUCCESS 0
#define RUN_FAIL 1


int get_local_ip_using_ifconf(char *str_ip)
{
    int sock_fd, intrface;
    struct ifreq buf[INET_ADDRSTRLEN];
    struct ifconf ifc;
    char *local_ip = NULL;
    int status = RUN_FAIL;

    if ((sock_fd = socket(AF_INET, SOCK_DGRAM, 0)) >= 0)
    {
        ifc.ifc_len = sizeof(buf);
        ifc.ifc_buf = (caddr_t)buf;
        if (!ioctl(sock_fd, SIOCGIFCONF, (char *)&ifc))
        {
            intrface = ifc.ifc_len/sizeof(struct ifreq);
            while (intrface-- > 0)
            {
                if (!(ioctl(sock_fd, SIOCGIFADDR, (char *)&buf[intrface])))
                {
                    local_ip = NULL;
                    local_ip = inet_ntoa(((struct sockaddr_in*)(&buf[intrface].ifr_addr))->sin_addr);
                    if(local_ip)
                    {
                        strcpy(str_ip, local_ip);
                        status = RUN_SUCCESS;
                        if(strcmp("127.0.0.1", str_ip))
                        {
                            break;
                        }
                    }

                }
            }
        }
        close(sock_fd);
    }
    return status;
}

extern "C" JNIEXPORT jstring JNICALL
Java_com_github_jing332_utils_NativeLib_getLocalIp(
        JNIEnv* env,
        jobject /* this */) {
    std::string hello = "Hello from C++";
    char str_ip[INET_ADDRSTRLEN];
    int status = get_local_ip_using_ifconf(str_ip);

    return env->NewStringUTF(str_ip);
}
