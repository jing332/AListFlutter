curl -L https://github.com/alist-org/alist-web/releases/latest/download/dist.tar.gz -o dist.tar.gz
tar -zxvf dist.tar.gz
rm -rf ../alist/public/dist
mv -f dist ../alist/public
rm -rf dist.tar.gz