class WarRoom::ListParser::Transformer < Parslet::Transformer
  rule(:total => simple(:n)) { Integer n }
end
