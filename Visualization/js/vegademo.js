function init() {
    var vegaOptions = {}
    var connector = new MapdCon()
      .protocol("http")
      .host("http://[::]:8000/")
      .port("6273")
      .dbName("linessa")
      .user("linessa")
      .password("series2")
      .connect(function(error, con) {
        con.renderVega(1, JSON.stringify(exampleVega), vegaOptions, function(error, result) {
          if (error) {
            console.log(error.message);
          }
          else {
            var blobUrl = `data:image/png;base64,${result.image}`
            var body = document.querySelector('body')
            var vegaImg = new Image()
            vegaImg.src = blobUrl
            body.append(vegaImg)
          }
        });
      });
  }