import 'package:flutter/material.dart';

class SliverScreenDemo extends StatefulWidget {
  const SliverScreenDemo({Key key}) : super(key: key);

  @override
  _SliverScreenDemoState createState() => _SliverScreenDemoState();
}

class _SliverScreenDemoState extends State<SliverScreenDemo> {
  ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sliver demo'),
      ),
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          _buildSliverAppBar(),
          _buildSliverToBoxAdapter(),
          _buildSliverGrid(context),
          _buildSliverFixedExtentList(context),
          _buildSliverFillViewport(),
        ],
      ),
    );
  }
  
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      expandedHeight: 200,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text('sliver Demo',
          style: TextStyle(
            color: Colors.black
          ),
        ),
        background: Image.network(
          "https://www.snapphotography.co.nz/wp-content/uploads/New-Zealand-Landscape-Photography-prints-12.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSliverToBoxAdapter() {
    return SliverToBoxAdapter(
      child: Container(
        height: 100,
        color: Colors.pinkAccent.withOpacity(0.8),
        child: Center(
          child: Text(
            'SliverToBoxAdapter',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),

    );
  }

  Widget _buildSliverGrid(BuildContext context){
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
        childAspectRatio: 4.0,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.teal[100 * (index % 10)],
            child: Text('Sliver Grid Item $index'),
          );
        },
        childCount: 10,
      ),
    );
  }

  Widget _buildSliverFixedExtentList(BuildContext context) {

    return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 10)],
                child: Text('Sliver Fixed Extent List Item $index'),
              );
            },
          childCount: 10
        ),
        itemExtent: 100,
    );
  }

  Widget _buildSliverFillViewport() {
    return SliverFillViewport(
      delegate: SliverChildListDelegate(
        [
          Container(
            height: 100,
            color: Colors.pinkAccent.withOpacity(0.8),
            child: Center(
              child: Text(
                'SliverFillViewport',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      viewportFraction: 1,
    );
  }
}
