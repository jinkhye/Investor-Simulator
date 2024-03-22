// ignore_for_file: file_names

class NewsModel {
  String name;
  String iconPath;
  int hours;
  String description;

  NewsModel(
      {required this.name,
      required this.iconPath,
      required this.hours,
      required this.description});

  static List<NewsModel> getNews() {
    List<NewsModel> news = [];

    news.add(NewsModel(
      name: 'Tesla Unveils Groundbreaking Battery Technology',
      iconPath: 'assets/images/news1.png',
      hours: 9,
      description:
          'In a groundbreaking announcement today, Tesla revealed a revolutionary advancement in battery technology that promises to reshape the electric vehicle industry and significantly accelerate the global transition to sustainable energy. The unveiling of this cutting-edge innovation sent shockwaves through the financial markets, propelling Tesla\'s stock price to new heights.\n\nCEO Elon Musk introduced the world a next-generation battery cell with unparalleled energy density and longevity. This leap forward in battery technology is aimed to address the longstanding challenges of range anxiety and charging times, effectively eliminating barriers to widespread EV adoption.',
    ));

    news.add(NewsModel(
        name:
            'Apple Announces Revolutionary Augmented Reality Glasses, Igniting Investor Excitement',
        iconPath: 'assets/images/news2.png',
        hours: 23,
        description:
            'In a move that has sent ripples of excitement through the tech world, Apple has unveiled its latest innovation: Augmented Reality (AR) glasses. The announcement, made amidst much anticipation, has ignited fervor among investors and consumers alike.\n\nApple\'s AR glasses promise to revolutionize how we interact with technology and the world around us. With seamless integration into the Apple ecosystem, these glasses are poised to offer immersive experiences, blending digital elements with the real world in ways previously unimaginable.\n\nAs anticipation builds for their release, speculation abounds regarding the potential applications of this groundbreaking technology, from gaming and entertainment to productivity and communication. Apple\'s foray into AR is seen as a bold step forward, reaffirming the company\'s commitment to innovation and pushing the boundaries of what is possible in the realm of technology.'));

    news.add(NewsModel(
        name: 'Microsoft Faces Regulatory Scrutiny Over Antitrust Concerns',
        iconPath: 'assets/images/news3.png',
        hours: 23,
        description:
            'Microsoft finds itself under the regulatory spotlight once again as concerns over antitrust violations mount. The tech giant, long a dominant force in the industry, is facing increased scrutiny from government authorities over its business practices.\n\nAt the heart of the issue are allegations that Microsoft has engaged in anti-competitive behavior, stifling competition and limiting consumer choice. These concerns have prompted calls for regulatory intervention to ensure a level playing field in the tech sector.\n\nAs investigations unfold, Microsoft is under pressure to address these allegations and demonstrate its commitment to fair competition. The outcome of these proceedings could have far-reaching implications not only for Microsoft but for the broader tech industry as well, shaping the landscape of competition and innovation for years to come.'));

    return news;
  }
}
