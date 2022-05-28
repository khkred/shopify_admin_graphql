import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shopify_admin_graphql/store_products.dart';

class ShopList extends StatefulWidget {
  const ShopList({Key? key}) : super(key: key);

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  final storeQuery = """{
  shop {
    name
    currencyCode
    taxesIncluded
  }
}""";

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        "https://graphy1.myshopify.com/admin/api/2022-04/graphql.json",
        defaultHeaders: {
          "X-Shopify-Access-Token": "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"
        });
    GraphQLClient graphQlClient = GraphQLClient(
        link: httpLink, cache: GraphQLCache(store: InMemoryStore()));

    ValueNotifier<GraphQLClient> client = ValueNotifier(graphQlClient);

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        body: Query(
          options: QueryOptions(
            document: gql(storeQuery),

          ),
          builder: (QueryResult result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            Map shop = result.data?['shop'];

            return Center(
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Text("Shop Name: "+shop['name']),
                  subtitle: Text("Currency: "+shop['currencyCode']),
                  trailing: IconButton(
                    icon: const Icon(Icons.forward),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StoreProducts()),
                      );
                    },
                  )
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
