module ApplicationHelper
  def default_meta_tags
    {
      site: 'いくら。',
      title: '転職中のお金管理アプリ',
      reverse: true,
      charset: 'utf-8',
      description: '転職活動中のお金の不安を解消。収入・支出を登録するだけで今使える金額が自動算出されます。',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        local: 'ja-JP'
      },
      twitter: {
        card: 'summary_large_image',
        image: image_url('ogp.png')
      }
    }
  end
end