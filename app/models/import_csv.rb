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
    puts "インポート処理を開始"
    begin
      User.create(list)
      puts "インポート完了！！"
    rescue ActiveModel::UnknownAttributeError => invalid
      puts "インポートに失敗しました"
    end
  end
end