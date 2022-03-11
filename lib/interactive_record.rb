# require_relative "../config/environment.rb"
# require 'active_support/inflector'

# class InteractiveRecord
#     def self.table_name
#         self.to_s.downcase.pluralize
#     end

#     def column_names
#         column_names = []
#         DB[:conn].execute("PRAGMA table_info('#{table_name}')").each do |column|
#             column_names << column["name"]
#         end
#         column_names.compact
#     end

#     def initialize(options = {})
#         options.each do |property, value|
#             self.send("#{property}=", value)
#         end
#     end

#     def table_name_for_insert
#         self.class.table_name
#     end

#     def columns_for_insert
#         self.class.column_names.delete_if {|col| col == "id"}.join(", ")
#     end

#     def values_for_insert
#         values = []
#         self.class.column_names.each do |col|
#             values << "'#{send(col)}'" unless send(col).nil?
#         end
#         values.join(", ")
#     end

#     def save
#         DB[:conn].execute("INSERT INTO #{table_name_for_insert} (#{columns_for_insert}) VALUES (?)", [values_for_insert])

#         @id = DB[:conn].execute("SELECT last_insert_rowid() FROM #{table_name_for_insert}")[0][0]
#     end

#     def self.find_by(hash)
#         value = hash.values.first
#         formatted_value = value.class == Fixnum ? value : "'#{value}'"
#         sql = "SELECT * FROM #{self.table_name} WHERE #{hash.keys.first} = #{formatted_value}"
#         DB[:conn].execute(sql)
#     end
# end