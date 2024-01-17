GIT_REPO="https://github.com/alist-org/alist.git"

TAG_NAME=$(git -c 'versionsort.suffix=-' ls-remote --exit-code --refs --sort='version:refname' --tags $GIT_REPO | tail --lines=1 | cut --delimiter='/' --fields=3)

echo "AList - ${TAG_NAME}"
git clone --branch "$TAG_NAME" https://github.com/alist-org/alist.git ../alist