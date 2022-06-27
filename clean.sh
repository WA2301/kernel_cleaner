#!/bin/bash

dir=$1
src=${dir}.bak
dst=${dir}

files=$(cat ${dir}/compile_commands.json | jq -r '.[]|.file')

subdirs='drivers arch fs sound net crypto mm'
for subdir in ${subdirs}
do
	find ${dir}/${subdir} -name '*.c' -o -name '*.S' | xargs rm -rf
	for file in ${files[@]}
	do 
		if [[ ${file} == "${subdir}/"* ]]; then
			cp -rf ${src}/$file ${dst}/$file 2>/dev/null
		fi 
	done

	makefiles=$(find ${dir}/${subdir} -name 'Makefile' -type f)
	for makefile in ${makefiles[@]}
	do
		if [[ $(find ${makefile%Makefile} -name "*.c" -o -name "*.S" | wc -l) -eq 0 ]] ; then
			find ${makefile%Makefile} -name '*.h' | xargs rm -rf
		fi
	done
done

# for fix
cp -r -n ${src}/drivers/usb/host/ ${dir}/drivers/usb/
cp -r -n ${src}/drivers/firmware ${dir}/drivers/

cp -rf -n ${src}/arch/x86 ${dst}/arch

cp -rf -n ${src}/fs/xfs ${dst}/fs
cp -rf -n ${src}/net/bridge ${dst}/net

cp -rf -n ${src}/mm/percpu-vm.c ${dst}/mm/


find ${dst}/drivers/gpu/drm/amd -name '*.h' | xargs rm -rf # So TM big .h files ...

# delete more
rm -rf ${dst}/Documentation
