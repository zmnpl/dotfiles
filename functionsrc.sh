alias grep-key-code='___grep-key-code'
function ___grep-key-code {
	xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}

# notes
function note {
	vim ~/Nas/Notes/$1.md
}

# note taking
function ___find_note {
	grep -rn --exclude-dir="*evernote*" --exclude-dir="*archiv*" "$1" ~/Nas/Notes
}
alias "findnote"='___find_note'

meh () {
	git add .
	git commit --m "-"
	git push
}

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

plop () {
    open=xdg-open   # this will open pdf file withthe default PDF viewer on KDE, xfce, LXDE and perhaps on other desktops.

    ag -U -g ".pdf$" \
    | ding -fp \
	| fzf --height=90% --no-hscroll --read0 --reverse -e -d $'\t'  \
        --preview-window down:80% --preview '
            v=$(echo {q} | tr " " "|");
            echo -e {1}"\n"{2} | grep -E "^|$v" -i --color=always;
        ' \
    | cut -z -f 1 -d $'\t' | tr -d '\n' | xargs -r --null $open > /dev/null 2> /dev/null
}

plap () {
ag -g ".pdf$" \
    | awk 'BEGIN {FS="\t"; OFS="\t"}; {command="pdftotext -f 1 -l 1 \""$0"\" - 2>/dev/null | tr \"\n\" \"_\" "; command|getline d; close(command); print $0, d}' #\
   # | fzf -e \
   # --preview-window up:50% \
   # --preview "pdftotext -f 1 -l 1 '{1}' - " \
   # | awk 'BEGIN {FS="\t"; OFS="\t"}; {print $1}' \
   # | xargs gio open
}
