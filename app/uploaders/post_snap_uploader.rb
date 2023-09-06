class PostSnapUploader < CarrierWave::Uploader::Base
  # MiniMagickを使って画像のリサイズなどを行う
  include CarrierWave::MiniMagick

  # ストレージのタイプを指定
  storage :file

  # 保存先ディレクトリ
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # ファイルがアップロードされていない場合のデフォルトURL
  def default_url
    'sample.jpg'
  end

  # アップロードを許可する拡張子
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # 画像をリサイズ
  process resize_to_fit: [800, 800]

  # サムネイル用のバージョン（オプション）
  version :thumb do
    process resize_to_fill: [200, 200]
  end
end
