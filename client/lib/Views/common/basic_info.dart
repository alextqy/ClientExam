import 'package:client/public/lang.dart';

List<int> perPageDropList = <int>[10, 50, 100];
List<String> stateDropList = <String>[
  Lang().all,
  Lang().normal,
  Lang().disable
];

/// exam-info
List<String> examStatusList = <String>[
  Lang().notSelected,
  Lang().noAnswerCards,
  Lang().notExamined,
  Lang().examined,
  Lang().examVoided,
];
List<String> examTypeList = <String>[
  Lang().notSelected,
  Lang().officialExams,
  Lang().dailyPractice,
];
List<String> passList = <String>[
  Lang().notSelected,
  Lang().yes,
  Lang().no,
];
List<String> startStateList = <String>[
  Lang().notSelected,
  Lang().notStarted,
  Lang().started,
];
List<String> suspendedStateLIst = <String>[
  Lang().notSelected,
  Lang().yes,
  Lang().no,
];