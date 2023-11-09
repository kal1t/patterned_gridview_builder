![Screenshot_1699511419](https://github.com/kal1t/patterned_gridview_builder/assets/143402227/849b7fb4-3c3c-4fba-9658-eb0e93aa4a96)# patterned_gridview_builder

This is a patterned_grid. It creates elements in the widget's specific proportion pattern in a row. This is done to create a custom design where elements can be of various sizes
## usage:

```
CustomPatternedGrid(
  childHeight: 150,
  physics: const NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  padding: const EdgeInsets.symmetric(horizontal: 10),
  inputFlexPattern: const [
    [2, 1],
    [1, 1, 1],
    [1, 2],
    [3, 3],
  ],
  itemCount: childCategories.length,
  itemBuilder: (context, index, flexPattern) {
    return CatalogCard(
      onTap: ...,
      title: ...,
      image: ...,
    );
  },
),
```
## output ->
![Screenshot_1699511419](https://github.com/kal1t/patterned_gridview_builder/assets/143402227/d101de15-4b7c-43a7-b996-2474272cddbb)

