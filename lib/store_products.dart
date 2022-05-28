import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StoreProducts extends StatefulWidget {
  const StoreProducts({Key? key}) : super(key: key);

  @override
  State<StoreProducts> createState() => _StoreProductsState();
}

class _StoreProductsState extends State<StoreProducts> {
  final document = """{
    products(first: 2) {
      edges {
        node {
          id
          title
        }
      }
    }
  }""";

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        "https://graphy1.myshopify.com/admin/api/2022-04/graphql.json",
        defaultHeaders: {
          "X-Shopify-Access-Token": "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",
          "Content-Type":"application/json"
        });
    GraphQLClient graphQlClient = GraphQLClient(
        link: httpLink, cache: GraphQLCache(store: InMemoryStore()));

    ValueNotifier<GraphQLClient> client = ValueNotifier(graphQlClient);

    return GraphQLProvider(
      client: client,
      child: Scaffold(
          body: Query(
        options: QueryOptions(document: gql(document)),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List edges = result.data?['products']['edges'];

          return ListView.builder(
              itemCount: edges.length,
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    title: Text(edges[index]['node']['title']),
                  ),
                );
              });

          print(result);

          return Text("Something");
        },
      )),
    );
  }
}
