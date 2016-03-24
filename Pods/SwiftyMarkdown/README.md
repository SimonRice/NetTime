# SwiftyMarkdown

SwiftyMarkdown converts Markdown files and strings into NSAttributedString using sensible defaults and a Swift-style syntax. It uses dynamic type to set the font size correctly with whatever font you'd like to use

## Usage

Text string

	let md = SwiftyMarkdown(string: "# Heading\nMy *Markdown* string")
	md.attributedString()

URL 

	if let url = NSBundle.mainBundle().URLForResource("file", withExtension: "md"), md = SwiftyMarkdown(url: url ) {
		md.attributedString()
	}

## Customisation 

	md.body.fontName = "AvenirNextCondensed-Medium"

	md.h1.color = UIColor.redColor()
	md.h1.fontName = "AvenirNextCondensed-Bold"

	md.italic.color = UIColor.blueColor()

## Screenshot

![Screenshot](http://f.cl.ly/items/12332k3f2s0s0C281h2u/swiftymarkdown.png)