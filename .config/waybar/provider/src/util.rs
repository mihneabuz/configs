use serde::Serialize;
use serde_json;

#[derive(Serialize)]
pub struct Result<'a> {
    text: &'a str,
    alt: &'a str,
    class: &'a str,
    percentage: u8,
}

impl Result<'_> {
    pub fn to_string(&self) -> String {
        serde_json::to_string(self).unwrap()
    }

    pub fn print(self) {
        println!("{}", self.to_string());
    }
}

pub struct ResultBuilder<'a> {
    text: Option<&'a str>,
    alt: Option<&'a str>,
    class: Option<&'a str>,
    percentage: Option<u8>,
}

impl<'a> ResultBuilder<'a> {
    pub fn new() -> Self {
        ResultBuilder{
            text: None,
            alt: None,
            class: None,
            percentage: None
        }
    }

    pub fn with_text(mut self, text: &'a str) -> Self {
        self.text.replace(text);
        self
    }

    pub fn with_class(mut self, class: &'a str) -> Self {
        self.class.replace(class);
        self
    }

    pub fn with_alt(mut self, alt: &'a str) -> Self {
        self.alt.replace(alt);
        self
    }

    pub fn with_percentage(mut self, value: u8) -> Self {
        self.percentage.replace(value);
        self
    }

    pub fn build(self) -> Result<'a> {
        Result {
            text: self.text.unwrap_or_default(),
            alt: self.alt.unwrap_or_default(),
            class: self.class.unwrap_or_default(),
            percentage: self.percentage.unwrap_or_default()
        }
    }
}
