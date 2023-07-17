# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
  email: 'joker.admin@examples.com',
  password: 'testtest'
)

users = User.create!(
  [
    { first_name: "犬山", last_name: "犬尾", first_name_kana: "イヌヤマ", last_name_kana: "イヌオ", user_name: "犬シロウ", introduction: "初めまして！", email: "inuinu@dogtest.com", password: "password"},
    { first_name: "鳥土", last_name: "羽子", first_name_kana: "トリツチ", last_name_kana: "ハネコ", user_name: "バード3世", introduction: "こんにちは！", email: "bardhane@tori.com", password: "testtest"},
    { first_name: "猫森", last_name: "ミケ", first_name_kana: "ネコモリ", last_name_kana: "ミケ", user_name: "ミケさん", introduction: "こんばんは！", email: "nekoneko@mike.com", password: "nekoneko"}
  ]
)

post_params = [
    {user_id: users[0].id, name: "金閣寺", address: "〒603-8361 京都府京都市北区金閣寺町1", latitude: "35.03937", longitude: "135.7292431",
      introduction:  "京都市にある金閣寺は、美しい金箔が張られた舎利殿が有名です。鹿苑寺の境内にあり、鏡湖池越しに見る金閣は特に美しいと言われています。参拝料金は500円で、修学旅行生や海外からの 旅行者で賑わっています。\r\n#金閣寺"},
                    
    {user_id: users[0].id, name: "函館山", address: "〒040-0000 北海道函館市 函館山", latitude: "41.7592941", longitude: "140.703917", 
      introduction: "函館市にある函館山は、北海道屈指の美しい夜景が魅力です。展望台からは函館市の夜景を一望することができます。また、山頂展望台までの登山道もあり、自然を楽しみながら歩くこともできます。\r\n#北海道 #函館"},
                   
    {user_id: users[0].id, name: "東京ディズニーランド", address: "〒279-0031 千葉県浦安市舞浜1-1", latitude: "35.6328964", longitude: "139.8803943", 
      introduction: "東京都浦安市にある東京ディズニーランドは、日本を代表する大型テーマパークです。ディズニーキャラクターとの出会いや、エキサイティングなアトラクション、パレードなど、多彩なエンターテイメントが楽しめます。\r\n#東京 #ディズニーランド #ミッキー"},
                  
    {user_id: users[1].id, name: "雪国・五箇山合掌造り集落", address: "〒501-5627 岐阜県大野郡白川村荻町 白川郷", latitude: "36.2577967", longitude: "136.9061975", 
      introduction:    "日本の雪国を代表する合掌造り集落があります。冬の雪景色が美しいことで知られており、伝統的な農村風景や合掌造りの建物を楽しむことができます。\r\n#世界遺産"},
      
    {user_id: users[1].id, name: "厳島神社", address: "〒739-0588 広島県廿日市市宮島町１−１", latitude: "34.29598960000001", longitude: "132.3198285", 
      introduction: "広島県廿日市市にある厳島神社は、日本三景のひとつである厳島（宮島）に鎮座しています。美しい鳥居や朱色の建物が海に浮かぶ光景は、多くの観光客を魅了しています。\r\n#世界遺産"},
      
    {user_id: users[1].id, name: "名古屋城", address: "〒460-0031 愛知県名古屋市中区本丸１−１", latitude: "35.1847501", longitude: "136.8996883", 
     introduction: "愛知県名古屋市にある名古屋城は、江戸時代に築かれた歴史的な城です。美しい天守閣や広大な敷地が特徴であり、城内には資料館も併設されています。\r\n#"},
    
    {user_id: users[2].id, name: "雲仙岳", address: "〒859-1317 長崎県雲仙市国見町土黒庚 雲仙岳", latitude: "32.7804514", longitude: "130.2672342", 
     introduction: "長崎県雲仙市にある雲仙岳は、活火山で知られています。標高1,359メートルの山頂からは、壮大な景色を眺めることができます。\r\n#"},
    
    {user_id: users[2].id, name: "知床", address: "〒099-4356 北海道斜里郡斜里町遠音別村 知床半島", latitude: "44.1996561", longitude: "145.2396744", 
     introduction: "北海道斜里町に位置する知床は、美しい自然景観が広がる国立公園です。断崖絶壁や温泉、野生動物などが魅力であり、ハイキングや野生動物観察が楽しめます。\r\n#世界遺産"},
    
    {user_id: users[2].id, name: "富士山", address: "〒418-0112 静岡県富士宮市北山 富士山", latitude: "35.3606255", longitude: "138.7273634",  
    introduction: "富士山は、日本を代表する観光地の一つです。山梨県と静岡県にまたがっており、その美しい姿勢と壮大な景色が人々を魅了しています。登山や山麓での観光など、さまざまな楽しみ方があります。\r\n#富士山 #世界遺産"},
    
    {user_id: users[2].id, name: "小笠原諸島", address: "小笠原諸島", latitude: "26.9641919", longitude: "142.1063337", 
     introduction: "東京都小笠原村に位置する島々のグループです。父島、母島、聟島、硫黄島、西之島、沖ノ鳥島、南鳥島など約30の島々から成り立っています。小笠原諸島は太平洋に位置 し、日本本土から約1,000キロメートル離れています。\r\n#世界遺産"}
  ]

post_params.each.with_index(1) do |data, i|
  post = Post.create!(data)
  range = []
  if i == 1 || i == 2
    range = (1..3)
  elsif i == 3
    range = (1..2)
  end
  range.each do |n|
    post.images.attach(io: File.open(Rails.root.join("db/fixtures/#{i}_#{n}.jpg")), filename: "#{i}_#{n}.jpg")
  end
end
