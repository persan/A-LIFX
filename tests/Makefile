all:
ifeq ("${MAKELEVEL}","0")
	${MAKE} -C .. ${@}
else
	${MAKE} compile test
endif

compile:
ifeq ("${MAKELEVEL}","0")
	${MAKE} -C .. ${@}
else
	gprbuild -P lifx-tests.gpr
endif

test:
ifeq ("${MAKELEVEL}","0")
	${MAKE} -C .. ${@}
else
endif


clean:
ifeq ("${MAKELEVEL}","0")
	${MAKE} -C .. ${@}
else
endif

