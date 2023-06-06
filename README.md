# BuildIt
BuildIt is a collection of mkfiles, shell scripts, and external tools to build Linux From Scratch

# Building the toolkit
To build the toolkit run:
```
sh build.sh
```

# Entering the BuildIt shell
To enter the BuildIt shell:
```
cd buildit
./buildit-shell
```

# Building the LFS system
```
mk -f $BUILDIT/stages.mk
```
(If an error occurs you can run the mk command again and it will start back at the pkg it left off at)

# To wipe the LFS system entirely
```
mk -f $BUILDIT/stages.mk
```

# To build specific stages
```
mk -f $BUILDIT/stages.mk stage1
```
Availabe stages:
stage1
stage2
stage3
stage4

(Each stage is dependent on stages before it)
