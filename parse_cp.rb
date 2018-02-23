#!/usr/bin/env ruby
#encoding: utf-8

require 'csv'
require 'pp'
require 'mongo'
$mongo = Mongo::MongoClient.new.db('codigos_postales')

estados = {}

# Limpiamos el archivo de ingesta, pasándo lo de windows-latin-1 a utf8 y quitando la primera línea pendeja
`iconv -f ISO-8859-15 -t UTF-8 CPdescarga.txt | sed '1d' > CPdescarga-utf8.txt`

CSV.foreach("CPdescarga-utf8.txt", headers: true, encoding: "UTF-8", col_sep:'|', quote_char:'|') do |row|
  
  if (row.count > 15)
    pp row.to_hash()
    next
  end
  
  estado = row['c_estado'].to_i
  
  doc = {
    _id: row['d_codigo']+'-'+row['id_asenta_cpcons'],
    cp: row['d_codigo'],
    estado: estado,
    municipio: row['D_mnpio'].strip,
    colonia: row['d_asenta'].strip,
    tipo: row['d_tipo_asenta'].downcase.strip,
    zona: row['d_zona'].downcase.strip
  }
  
  if (row['d_ciudad'])
    doc[:ciudad] = row['d_ciudad'].strip
  end
  
  if ( !estados.has_key?(estado) )
    puts "Agregando #{row['d_estado']}: #{row['c_estado']}";
    estados[estado] = row['d_estado'].strip
    $mongo['estados'].save({_id:estado, nombre:row['d_estado']})
  end

  $mongo['cp'].save(doc)

end
