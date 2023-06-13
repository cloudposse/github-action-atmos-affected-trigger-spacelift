#!/usr/bin/env bash

echo '<details><summary>Spacelift runs</summary>

```' > hidden-comment-body.txt

cat comment-body.txt >> hidden-comment-body.txt

echo '```

</details>' >> hidden-comment-body.txt
