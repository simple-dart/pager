import 'package:simple_dart_image_button/simple_dart_image_button.dart';
import 'package:simple_dart_label/simple_dart_label.dart';
import 'package:simple_dart_num_field/simple_dart_num_field.dart';
import 'package:simple_dart_ui_core/simple_dart_ui_core.dart';

class Pager extends PanelComponent {
  late Pageable pageable;

  ImageButton btnFirst = ImageButton()
    ..source = 'images/pager_first.svg'
    ..width = '16px'
    ..height = '16px';
  ImageButton btnPrev = ImageButton()
    ..source = 'images/pager_prev.svg'
    ..width = '16px'
    ..height = '16px';
  ImageButton btnNext = ImageButton()
    ..source = 'images/pager_next.svg'
    ..width = '16px'
    ..height = '16px';
  ImageButton btnLast = ImageButton()
    ..source = 'images/pager_last.svg'
    ..width = '16px'
    ..height = '16px';

  NumField numField = NumField()
    ..width = '50px'
    ..height = '19px'
    ..textAlign = Align.center
    ..element.style.marginLeft = '5px'
    ..element.style.marginRight = '5px';
  Label lblCount = Label()
    ..height = '25px'
    ..caption = '/ 0'
    ..element.style.paddingLeft = '5px'
    ..element.style.paddingRight = '5px';

  Pager() : super('Pager') {
    add(btnFirst);
    add(btnPrev);
    add(numField);
    add(lblCount);
    add(btnNext);
    add(btnLast);
    spacing = '1px';
    vAlign = Align.center;
    hAlign = Align.center;
    btnFirst.onClick.listen((e) {
      pageable.currentPage = 1;
      refreshDisplay();
    });
    btnPrev.onClick.listen((e) {
      if (pageable.currentPage > 1) {
        pageable.currentPage = pageable.currentPage - 1;
        refreshDisplay();
      }
    });
    btnNext.onClick.listen((e) {
      if (pageable.currentPage < pageable.pageCount) {
        pageable.currentPage = pageable.currentPage + 1;
        refreshDisplay();
      }
    });
    btnLast.onClick.listen((e) {
      pageable.currentPage = pageable.pageCount;
      refreshDisplay();
    });
    numField.onValueChange.listen((e) {
      try {
        final newPageNum = numField.value.toInt();
        pageable.currentPage = newPageNum;
        refreshDisplay();
      } on Exception catch (_) {}
    });
  }

  void init(Pageable pageable) {
    this.pageable = pageable;
    refreshDisplay();
  }

  void refreshDisplay() {
    numField.value = pageable.currentPage;
    lblCount.caption = '/ ${pageable.pageCount}';
    btnFirst.disabled = pageable.currentPage == 1;
    btnLast.disabled = pageable.currentPage >= pageable.pageCount;
    btnPrev.disabled = btnFirst.disabled;
    btnNext.disabled = btnLast.disabled;
  }
}

abstract class Pageable {
  int get pageCount;

  int get currentPage;

  set currentPage(int newPage);
}
