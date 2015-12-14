package main

import (
	"fmt"
	"strconv"
)

func main() {
	a := "this is a test"
	b := "wokka wokka!!!"
	hd := strHamDist(a, b)
	if hd != 37 {
		panic("strHamDist func is broken!")
	}
	fmt.Println(hd, "it is.")
}

func strHamDist(s1, s2 string) int {
	t := 0

	//this loop is going over each byte, NOT each Rune.
	for k, v := range s1 {

		//let's convert the bytes to int64s so we can use FormatInt later.
		n1 := int64(v)
		n2 := int64(s2[k])

		//FormatInt(var int64 ,2) converts the var to a string representation of the base num of the second argument.
		//So the second argument of 2 converts the int64 var to base 2, or, binary.
		b1 := strconv.FormatInt(n1, 2)
		b2 := strconv.FormatInt(n2, 2)

		//This part is crucial.  The string representation will never be more than 7 characters in length,
		//but it might be less!!
		//fmt.Sprintf("07d",var string) will pad with enough leading zeros to make all the strings 7 characters.
		//Each character represents a bit.
		b1 = fmt.Sprintf("%07d", b1)
		b2 = fmt.Sprintf("%07d", b2)

		//This 2nd loop allows us to iterate over each bit, NOT the byte of the letter (or combination of bytes in a Rune).
		//So, we aren't just comparing 14 letter/bytes,
		//we're comparing 7*14 bits (not bytes!)
		//See this article about why ascii "bytes" have 7 bits and not 8.
		//http://stackoverflow.com/a/14690651
		for k := range b1 {
			if b1[k] != b2[k] {
				t++
			}
		}

	}
	return t
}
