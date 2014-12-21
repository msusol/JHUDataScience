if ( !file.exists("summarySCC_PM25.rds") && !file.exists("Source_Classification_Code.rds")) {
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  temp <- tempfile()
  download.file(fileURL, temp, method = "curl", mode="wb")
  unzip(temp, "summarySCC_PM25.rds")
  unzip(temp, "Source_Classification_Code.rds")
} else {
  if ( !file.exists("NEI_data.rsa") ) {
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    save(NEI,SCC, file="NEI_data.rsa")
    load("NEI_data.rsa")
  } else {
    load("NEI_data.rsa")
  }  
}
