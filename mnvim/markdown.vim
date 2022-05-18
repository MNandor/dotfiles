
function ShowMarkdownCode()
	"Whether we are inside a ``` block
	let codeblock=0 
	for linen in range(1, line('$'))
		let line = getline(linen)
		" Regex check if line starts with ```
		if trim(line) =~ '^```.*$'
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



function UpdateMarkdownCode()
	redir => lines
	call ShowMarkdownCode()
	redir END
	let lines = split(lines, "\n")
	call deletebufline(2, 1, '$')
	call setbufline(2, 1, lines)
	let lines = ""

endfunction

function ShowCode()
	:vnew
	autocmd TextChanged,TextChangedI * call UpdateMarkdownCode()
endfunction


" autocmd FileType markdown ++once call ShowCode()
