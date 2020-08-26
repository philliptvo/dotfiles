function cpdf ----description "Combines pdf files"
  gs -q -dNOPAUSE-dNOBATCH -sDEVICE=pdfwrite -sOutputFile="$1" "${@:2}"
end
