#!/bin/bash

### Constants
webName="Agus' Webpage"
outFolder="HTML"

### Functions
function genHTML {
    #
    # Generate HTML from Markdown files
    # 
    # Parameters:
    #   $1 : Markdown file
    #   $2 : Output HTML file
    #
    echo "Markdown ($1) to HTML5 ($2)"
    echo "<head>
         <title>$webName</title>
         <link rel=\"stylesheet\" href=\"css/air.css\">
         <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />
         </head>
         <body>" > $2

    # Generate HTML5 from markdown
    pandoc -f markdown -t html5 $1 >> $2

    echo "<center><div style=\"height: 2.5rem;\">" >> $2
    echo "<a href="https://github.com/agusnt" target="_blank">" >> $2
    cat $outFolder/images/icon/github.svg | sed 's/<svg/<svg style="max-height: 100%; width: auto; box-shadow: 0px 0px 0px; border-radius: 0%;"/g'>> $2
    echo "</a>" >> $2
    echo "<a href="https://orcid.org/0000-0002-3556-2244" target="_blank">" >> $2
    cat $outFolder/images/icon/orcid.svg | sed 's/<svg/<svg style="max-height: 100%; width: auto; box-shadow: 0px 0px 0px; border-radius: 0%;"/g'>> $2
    echo "</a>" >> $2
    echo "<a href="mailto:agusnt@unizar.es" target="_blank">" >> $2
    cat $outFolder/images/icon/envelope.svg | sed 's/<svg/<svg style="max-height: 100%; width: auto; box-shadow: 0px 0px 0px; border-radius: 0%;"/g'>> $2
    echo "</a>" >> $2
    echo "
        </div>
        <p><small>
        Feel free to reach out to me by email 
        <a href=\"mailto:agusnavarro11@gmail.com\" target=\"_blank\">agusnavarro11@gmail.com </a>
        or <a href=\"mailto:agusnt@gmail.com\" target=\"_blank\">agusnt@unizar.es </a>
        </p></small>
        </center>
        </body>" >> $2
}


### Main

# See if git, pandoc and wget are installed
command -v git >/dev/null 2>&1 || { echo >&2 "I require git but it's not installed.  Aborting."; exit 1; }
command -v pandoc >/dev/null 2>&1 || { echo >&2 "I require pandoc but it's not installed.  Aborting."; exit 1; }
command -v wget >/dev/null 2>&1 || { echo >&2 "I require wget but it's not installed.  Aborting."; exit 1; }

# Download css
echo "Download CSS"
git clone git@github.com:agusnt/air.git $outFolder/air > /dev/null 2>&1
mkdir $outFolder/css > /dev/null 2>&1
mv $outFolder/air/css/air.css $outFolder/css/air.css
rm -rf $outFolder/air

# Download fontawesome icons
echo "Download Icons"
git clone https://github.com/FortAwesome/Font-Awesome.git $outFolder/fontawesome > /dev/null 2>&1
mkdir -p $outFolder/images/icon > /dev/null 2>&1
mv $outFolder/fontawesome/svgs/solid/envelope.svg $outFolder/images/icon
mv $outFolder/fontawesome/svgs/brands/github.svg $outFolder/images/icon
mv $outFolder/fontawesome/svgs/brands/orcid.svg $outFolder/images/icon
rm -rf $outFolder/fontawesome

# Create folder
mkdir -p $outFolder > /dev/null 2>&1

# Generate HTML
for i in *.md; do
    if [[ "$i" == "README.md" ]]; then continue; fi
    genHTML $i $(echo "$outFolder/$(echo $i | cut -d'.' -f1).html")
done

# Delete image icons
rm -rf $outFolder/images/icon
