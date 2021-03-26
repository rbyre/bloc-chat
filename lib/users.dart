import 'package:bloc_chat/data/models/user.dart';

class Users {
  static get initUsers => <User>[
        User(
          name: 'Runar Byre',
          urlAvatar:
              'https://runarbyre.pythonanywhere.com/static/portfolio/Runar_cropped_new.png',
          lastMessageTime: DateTime.now(),
        ),
        User(
          name: 'Sjefen',
          urlAvatar:
              'https://kunstivest.no/____impro/1/webshopmedia/3031%2C%204%20MB%2C%20Sjefen_MG_0113%20kopier-1610531389500.jpg?&withoutEnlargement&resize=480,9999',
          lastMessageTime: DateTime.now(),
        ),
        User(
          name: 'Elon Musk',
          urlAvatar:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg/375px-Elon_Musk_Royal_Society_%28crop1%29.jpg',
          lastMessageTime: DateTime.now(),
        ),
        User(
          name: 'Erna Solberg',
          urlAvatar:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Erna_Solberg_Norges_Bank_%C3%85rstale_%28191341%29.jpg/375px-Erna_Solberg_Norges_Bank_%C3%85rstale_%28191341%29.jpg',
          lastMessageTime: DateTime.now(),
        ),
        User(
          name: 'Donald Trump',
          urlAvatar:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Donald_Trump_official_portrait.jpg/375px-Donald_Trump_official_portrait.jpg',
          lastMessageTime: DateTime.now(),
        ),
      ];
}
