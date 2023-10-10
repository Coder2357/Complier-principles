.PHONY:test,test1,test2,clean
test:
	arm-linux-gnueabihf-gcc example.S -o example.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./example.out
test1:
	arm-linux-gnueabihf-gcc program1.S -o program1.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./program1.out
test2:
	arm-linux-gnueabihf-gcc program2.S -o program2.out
	qemu-arm -L /usr/arm-linux-gnueabihf ./program2.out

clean:
	rm -fr *.out