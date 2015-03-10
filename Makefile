default: all

#buid dirs
##build root dirs

enc-build		:= submodule/encounter_tools/build
py-build		:= submodule/gds-to-txt
matlab-build	:= submodule/rectDecomp

##build tmp dirs

###post par file dir
post-par		:= $(enc-build)/enc-par/current
###python input & output dirs 
py-gds			:= $(py-build)/gds
py-txt			:= $(py-build)/txt
###matlab input & output dirs
m-txt			:= $(matlab-build)/txt
m-rect			:= $(matlab-build)/rect

##for clean
tmp-build		:= $(py-gds) $(py-txt) $(m-txt) $(m-rect)

all: matlab

enc:
	cd $(enc-build);\
	make;\
	cd -

py: enc
	rm -rf $(py-gds)/*.gds;\
	cp $(post-par)/*.gds $(py-gds);\
	cd $(py-build);\
	python dumpGDS.py;\
	cd -

matlab: py
	cd $(matlab-build);\
	matlab -nodisplay -nosplash -r "parse;quit;";\
	cd -

clean:
	cd $(enc-build);\
	make clean;\
	cd -;\
	rm -rf $(tmp-build)
	
