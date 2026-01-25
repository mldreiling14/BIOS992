docker build -t bios992 .

docker run -d \
	--name bios992 \
	-p 8787:8787 \
	-e PASSWORD=password \
	-v "/c/Users/drdre/bios992/:/home/rstudio/project" \
	bios992
