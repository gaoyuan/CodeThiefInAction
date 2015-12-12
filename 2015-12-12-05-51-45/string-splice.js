function spliceStr(str, i, count, add) {
	return str.slice(0, i) + (add || "") + str.slice(i + count);
}