function goPage(key, url, pages, lines){
	url += "?" +  "command=" + key + "&pages=" + pages + "&lines=" + lines;
	location.href = url;
}
