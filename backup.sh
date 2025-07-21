rm -rf ../backup/ || echo "Nothing to delete"
mkdir -p ../backup/blog
cp ~/Desktop/passwords.kdbx ../backup/
cp -r . ../backup/blog/
rm -rf ../backup/blog/_site
rm -rf ../backup/blog/.jekyll-cache/
rm -rf ../backup/blog/.git/
find ../backup/blog/ -type f -name '*.*~' -delete
find ../backup/blog/ -type f -name '#*' -delete

ack \
--ignore-dir _site \
--ignore-dir .jekyll-cache \
--no-filename \
. \
-o \
--match 'https://[a-zA-Z0-9_\-./=]+no' > ../urls.txt

wget --random-wait --content-disposition -i ../urls.txt

mkdir -p ../backup/images
mv *.jp* ../backup/images
mv *.png* ../backup/images

zip -r ../backup$(date +"-%d-%m-%Y").zip ../backup/

#clean up
rm -rf ../backup/
rm ../urls.txt

#list backups
ls -lah ../backup-*