package alistlib

import "net"

func GetOutboundIP() (net.IP, error) {
	conn, err := net.Dial("udp", "8.8.8.8:80")
	if err != nil {
		return nil, err
	}
	defer conn.Close()

	localAddr := conn.LocalAddr().(*net.UDPAddr)
	return localAddr.IP, nil
}

func GetOutboundIPString() string {
	netIp, err := GetOutboundIP()
	if err != nil {
		return "localhost"
	}

	return netIp.String()
}

