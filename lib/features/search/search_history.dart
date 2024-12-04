import 'package:dauys_remote/core/constants/app_icons.dart';
import 'package:dauys_remote/core/theme/app_colors.dart';
import 'package:dauys_remote/core/theme/app_styles.dart';
import 'package:dauys_remote/features/main/main_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../storage/local_storage.dart';

class SearchHistory extends StatefulWidget {
  final Function(String) callback;
  const SearchHistory({super.key, required this.callback});

  @override
  State<SearchHistory> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  List<String> _history = [];
  final LocalStorage localStorage = LocalStorage();

  @override
  void initState() {
    localStorage.getSearchHistory().then((history){
      setState(() {
        _history = history;
      });
    });
    print('SearchHistory rebuilt');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _history.length != 0
              ? 'Вы недавно искали'
              : 'Тут будет ваша история поиска',
            style: AppStyles.magistral20w500.copyWith(color: AppColors.white.withOpacity(0.5)),
          ),
        ),
        const SizedBox(height: 6),
        ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _history.length,
          itemBuilder: (context, index) => Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(
                AppIcons.history,
                height: 20,
                width: 20,
                color: AppColors.white.withOpacity(0.5),
              ),
              const SizedBox(width: 20),
              Expanded(
                child:
                GestureDetector(
                  onTap: (){
                    widget.callback(_history[index]);
                  },
                  child: Container(
                    height: 46,
                    alignment: Alignment.centerLeft,
                    decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.white.withOpacity(0.2)))),
                    child: Text(
                      _history[index],
                      style: AppStyles.magistral18w400.copyWith(color: AppColors.white),
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}
