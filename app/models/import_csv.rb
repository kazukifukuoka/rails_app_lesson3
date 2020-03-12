class ImportCsv < ApplicationRecord
  def self.import(path)
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << {
        name: row["name"],
        age: row["age"],
        address: row["address"]
      }
    end
    puts "インポート処理を開始".red
    begin
      User.transaction do
        User.create!(list)
      end
      puts "インポート完了！！".green
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "インポートに失敗しました".red
    end
  end
end