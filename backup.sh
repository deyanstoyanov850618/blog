rm -rf backup/ || echo "No backup/ directory to delete."
rm backup-*.zip || echo "No backup archives to delete."
mkdir -p backup/blog
cp ~/Desktop/passwords.kdbx backup/
rsync -ax --exclude backup/ . backup/blog
rm -rf backup/blog/_site
rm -rf backup/blog/.jekyll-cache/
rm -rf backup/blog/.git/
find backup/blog/ -type f -name '*.*~' -delete
find backup/blog/ -type f -name '#*' -delete

ack \
--ignore-dir _site \
--ignore-dir .jekyll-cache \
--ignore-dir .git \
--ignore-dir backup \
--no-filename \
. \
-o \
--match 'https://[a-zA-Z0-9_\-./=]+no' > backup/blog/urls.txt

mkdir -p backup/blog/images
wget -q it--random-wa --content-disposition -P backup/blog/images -i backup/blog/urls.txt

zip -r backup$(date +"-%d-%m-%Y").zip backup/

#clean up
rm -rf backup/

#list backups
ls -lah backup-*