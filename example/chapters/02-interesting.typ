= More Stuff <chapter-more>
#lorem(120)

== Subchapter
#lorem(250)

=== Subsubchapter
#lorem(250)

=== Another Subsubchapter
#lorem(100)

== Example of Table
#lorem(250)
#figure(
  table(
    columns: 3,
    table.header(
      [Substance],
      [Subcritical °C],
      [Supercritical °C],
    ),
    [Hydrochloric Acid],
    [12.0], [92.1],
    [Sodium Myreth Sulfate],
    [16.6], [104],
    [Potassium Hydroxide],
    table.cell(colspan: 2)[24.7],
  ),
  caption: [This new table]
)
#lorem(250)

== Example of Figure, Captioning, and Labeling
#lorem(50)
#figure(
  image(
    "../figures/politecat.jpg",
    width: 50%
  ),
  caption: [This is an image of polite cat.]
)<polite-cat-img>
As shown in @polite-cat-img, the image demonstrates a cat whom, we know, is polite.
