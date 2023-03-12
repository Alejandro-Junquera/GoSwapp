import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool puntosArriba;
  final Color colorFocus;
  final Color colorunFocus;
  final double bulletPrimario;
  final double bulletSecundario;
  const SlideShow(
      {super.key,
      required this.slides,
      this.puntosArriba = false,
      this.colorFocus = Colors.blueGrey,
      this.colorunFocus = Colors.grey,
      this.bulletPrimario = 12.0,
      this.bulletSecundario = 12.0});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SliderShowModel(
          colorFocus, colorunFocus, bulletPrimario, bulletSecundario),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              if (puntosArriba) _Dots(slides.length),
              Expanded(child: _Slides(slides: slides)),
              if (!puntosArriba) _Dots(slides.length),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  int numDots;
  _Dots(this.numDots);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 70,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(numDots, (i) => _Dot(i))));
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(
    this.index,
  );

  @override
  Widget build(BuildContext context) {
    final ssModel = Provider.of<_SliderShowModel>(context);
    double tamano;
    Color color;
    if (ssModel.currentPage >= index - 0.5 &&
        ssModel.currentPage < index + 0.5) {
      tamano = ssModel.bulletPrimario;
      color = ssModel.colorFocus;
    } else {
      tamano = ssModel.bulletSecundario;
      color = ssModel.colorunFocus;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;

  const _Slides({required this.slides});

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pagesViewController = PageController();

  @override
  void initState() {
    super.initState();
    pagesViewController.addListener(() {
      Provider.of<_SliderShowModel>(context, listen: false).currentPage =
          pagesViewController.page!;
    });
  }

  @override
  void dispose() {
    pagesViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: PageView(
        controller: pagesViewController,
        children: widget.slides.map((slide) => _Slide(slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget slide;
  const _Slide(this.slide);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(30),
      child: slide,
    );
  }
}

class _SliderShowModel with ChangeNotifier {
  double _currentPage = 0;
  late Color _colorFocus;
  late Color _colorunFocus;

  late double _bulletPrimario;
  late double _bulletSecundario;
  _SliderShowModel(this._colorFocus, this._colorunFocus, this._bulletPrimario,
      this._bulletSecundario);
  double get currentPage => _currentPage;
  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  Color get colorFocus => _colorFocus;
  set colorFocus(Color colorFocus) {
    _colorFocus = colorFocus;
  }

  Color get colorunFocus => _colorunFocus;
  set colorunFocus(Color colorunFocus) {
    _colorunFocus = colorunFocus;
  }

  double get bulletPrimario => this._bulletPrimario;
  set bulletPrimario(double tamano) {
    _bulletPrimario = tamano;
  }

  double get bulletSecundario => this._bulletSecundario;
  set bulletSecundario(double tamano) {
    _bulletSecundario = tamano;
  }
}
