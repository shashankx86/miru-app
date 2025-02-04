import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miru_app/pages/detail/view.dart';
import 'package:miru_app/router/router.dart';
import 'package:miru_app/widgets/cache_network_image.dart';
import 'package:miru_app/widgets/platform_widget.dart';

class ExtensionItemCard extends StatefulWidget {
  const ExtensionItemCard({
    Key? key,
    required this.title,
    required this.url,
    required this.package,
    required this.cover,
    this.update,
  }) : super(key: key);
  final String title;
  final String cover;
  final String? update;
  final String url;
  final String package;

  @override
  State<ExtensionItemCard> createState() => _ExtensionItemCardState();
}

class _ExtensionItemCardState extends State<ExtensionItemCard> {
  bool _isHover = false;

  Widget _buildAndroid(BuildContext context) {
    return Hero(
      tag: widget.url,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            clipBehavior: Clip.antiAlias,
            child: CacheNetWorkImage(
              widget.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 350,
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // 文字只显示一行
                    SizedBox(
                      height: 20,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (widget.update != null)
                      Text(
                        widget.update!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                  ],
                ),
              )),
          Positioned.fill(
              child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.to(DetailPage(
                    url: widget.url,
                    package: widget.package,
                    heroTag: widget.url,
                  ));
                },
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          _isHover = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHover = false;
        });
      },
      child: Column(
        // 居左
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                router.push(
                  Uri(
                    path: '/detail',
                    queryParameters: {
                      "url": widget.url,
                      "package": widget.package,
                    },
                  ).toString(),
                );
              },
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: AnimatedScale(
                    scale: _isHover ? 1.05 : 1,
                    duration: const Duration(milliseconds: 80),
                    child: CacheNetWorkImage(
                      widget.cover,
                      width: double.infinity,
                    ),
                  )),
            ),
          ),
          const SizedBox(height: 8),
          // 文字只显示一行
          SizedBox(
            height: 20,
            child: Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.update != null)
            Text(
              widget.update.toString(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformBuildWidget(
      androidBuilder: _buildAndroid,
      desktopBuilder: _buildDesktop,
    );
  }
}
