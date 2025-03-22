; extends

; return /* html */ $@"...string content highlighted as html..."
(return_statement
  (comment) @_comment (#match? @_comment ".+html.+")
  (interpolated_string_expression
  (string_content) @injection.content
  (#set! injection.language "html")
))
