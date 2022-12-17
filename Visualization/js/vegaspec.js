const series2Visual = {
    "$schema": "https://vega.github.io/schema/vega/v5.json",
    "width": 800,
    "height": 500,
    "padding": {"left": 5, "right": 5, "top": 20, "bottom": 0},
    "autosize": "none",
    "signals": [
      {"name": "cx", "update": "width / 2"},
      {"name": "cy", "update": "height / 2"},
      {
        "name": "gravityX",
        "value": 0.2,
        "bind": {"input": "range", "min": 0, "max": 1}
      },
      {
        "name": "gravityY",
        "value": 0.1,
        "bind": {"input": "range", "min": 0, "max": 1}
      }
    ],
    // NOTE: Data actually obtained by e.g.,
    // data: [
    //     {
    //         "name": "cloneclasses",
    //         "sql": "SELECT cloneclass as x, clonesnr as y, cloneClass.rowid FROM clone_detection" (or not sql)
    //     }
    // ],
    "data": [
      {
        "name": "table",
        "values": [
          {"category": "A", "amount": 0.28},
          {"category": "B", "amount": 0.55},
          {"category": "C", "amount": 0.43},
          {"category": "D", "amount": 0.91},
          {"category": "E", "amount": 0.81},
          {"category": "F", "amount": 0.53},
          {"category": "G", "amount": 0.19},
          {"category": "H", "amount": 0.87},
          {"category": "I", "amount": 0.28},
          {"category": "J", "amount": 0.55},
          {"category": "K", "amount": 0.43},
          {"category": "L", "amount": 0.91},
          {"category": "M", "amount": 0.81},
          {"category": "N", "amount": 0.53},
          {"category": "O", "amount": 0.19},
          {"category": "P", "amount": 0.87}
        ]
      }
    ],
    "scales": [
      {
        "name": "size",
        "domain": {"data": "table", "field": "amount"},
        "range": [100, 3000]
      },
      {
        "name": "color",
        "type": "ordinal",
        "domain": {"data": "table", "field": "category"},
        "range": "ramp"
      }
    ],
    "marks": [
      {
        "name": "nodes",
        "type": "symbol",
        "from": {"data": "table"},
        "encode": {
          "enter": {
            "fill": {"scale": "color", "field": "category"},
            "xfocus": {"signal": "cx"},
            "yfocus": {"signal": "cy"}
          },
          "update": {
            "size": {"signal": "pow(2 * datum.amount, 2)", "scale": "size"},
            "stroke": {"value": "white"},
            "strokeWidth": {"value": 1},
            "tooltip": {"signal": "datum"}
          }
        },
        "transform": [
          {
            "type": "force",
            "iterations": 100,
            "static": false,
            "forces": [
              {
                "force": "collide",
                "iterations": 2,
                "radius": {"expr": "sqrt(datum.size) / 2"}
              },
              {"force": "center", "x": {"signal": "cx"}, "y": {"signal": "cy"}},
              {"force": "x", "x": "xfocus", "strength": {"signal": "gravityX"}},
              {"force": "y", "y": "yfocus", "strength": {"signal": "gravityY"}}
            ]
          }
        ]
      },
      {
        "type": "text",
        "from": {"data": "nodes"},
        "encode": {
          "enter": {
            "align": {"value": "center"},
            "baseline": {"value": "middle"},
            "fontSize": {"value": 15},
            "fontWeight": {"value": "bold"},
            "fill": {"value": "white"},
            "text": {"field": "datum.category"}
          },
          "update": {"x": {"field": "x"}, "y": {"field": "y"}}
        }
      }
    ]
  }
  
// NOTE: Attempt with example 1
// const exampleVega = {
//     "width": 384,
//     "height": 564,
//     "data": [
//       {
//         "name": "tweets",
//         "sql": "SELECT goog_x as x, goog_y as y, tweets_data_table.rowid FROM tweets_data_table"
//       }
//     ],
//     "scales": [
//       {
//         "name": "x",
//         "type": "linear",
//         "domain": [
//           -3650484.1235206556,
//           7413325.514451755
//         ],
//         "range": "width"
//       },
//       {
//         "name": "y",
//         "type": "linear",
//         "domain": [
//           -5778161.9183506705,
//           10471808.487466192
//         ],
//         "range": "height"
//       }
//     ],
//     "marks": [
//       {
//         "type": "points",
//         "from": {
//           "data": "tweets"
//         },
//         "properties": {
//           "x": {
//             "scale": "x",
//             "field": "x"
//           },
//           "y": {
//             "scale": "y",
//             "field": "y"
//           },
//           "fillColor": "blue",
//           "size": {
//             "value": 3
//           }
//         }
//       }
//     ]
//   };

// NOTE: Attempt with example 2
// const exampleVega = {
//     "width": 384,
//     "height": 564,
//     "data": {
//       "values": [
//         {"a": "C", "b": 2}, {"a": "C", "b": 7}, {"a": "C", "b": 4},
//         {"a": "D", "b": 1}, {"a": "D", "b": 2}, {"a": "D", "b": 6},
//         {"a": "E", "b": 8}, {"a": "E", "b": 4}, {"a": "E", "b": 7}
//       ]
//     },
//     "mark": "bar",
//     "encoding": {
//       "y": {"field": "a", "type": "nominal"},
//       "x": {"aggregate": "average", "field": "b", "type": "quantitative"}
//     }
//   }