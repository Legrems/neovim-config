return {
  { "Replace {{X}} with {{ X }} in jinja template", "%s/{{\\(.[^ ]*\\)}}/{{ \\1 }}/g" },
  { "Replace a text newline with a carriage return", "%s/\\\\n/\\r/g" },
}
