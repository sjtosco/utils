# Ajax using fetch

Replace Jquery AJAX with JS native implementation using fetch.
In URL example, is used `url_for` Flask method and pass `ajax_ms` as jinja2 variable.

[See Support](https://caniuse.com/fetch)

Use:

```
<script>
const url = "{{ url_for('index.update') }}";
function fetchData(url) {
  const sendType = "POST";
  fetch(url, {method: sendType})
    .then(response => response.json())
    .then(response => updateView(response))
    .catch(err => console.log(err))
  // console.log(response);
  }
function updateView(response){
  document.getElementById("time").innerText = response["time"];
  document.getElementById("topic").innerText = response["topic"];
  document.getElementById("payload").innerText = JSON.stringify(response["payload"]);
  //document.getElementById("payload").innerText = JSON.stringify(response["payload"]);
}

setInterval("fetchData(url)", {{ ajax_ms }});
</script>
```

As replacement of:

```
<script>
  setInterval(function(){$.ajax({
        url: "{{ url_for('index.update')}}",
        type: "POST",
        success: function(response) {
            // console.log(response);
            $("#time").html(response["time"]);
            $("#topic").html(response["topic"]);
            $("#payload").html(response["payload"]);
            //$("#payload").html(JSON.stringify(response["payload"]));
        },
        error: function(error) {
            console.log(error);
        }
    })}, 1000);
</script>
```
