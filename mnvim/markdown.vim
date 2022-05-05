
function Code()
	"Whether we are inside a ``` block
	let codeblock=0 
	for linen in range(1, line('$'))
		let line = getline(linen)
		if trim(line) == '```'
			let codeblock = !codeblock
		elseif codeblock
			echo line
		else
			" Outside codeblocks, handle `inline` code content
			let parts = split(" ".line." ", '`')
			call filter(parts, {key, value -> key %2 == 1})
			if parts != []
				echo join(parts, " ")
			endif
		endif
	endfor
endfunction
