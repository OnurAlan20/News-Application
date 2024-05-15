import UIKit

class SearchTextField: UITextField{
    typealias SearchIconTapAction = () -> Void

  
    
    var searchIconTapAction: SearchIconTapAction?

    init(searchIconTapAction: SearchIconTapAction?) {
        self.searchIconTapAction = searchIconTapAction
        super.init(frame: .zero)
        setupTextField()
        delegate = self

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
        delegate = self

    }
    
    
    private func setupTextField() {
        returnKeyType = .search
        placeholder = "Search"
        backgroundColor = UIColor(rgb:0xEEEDEB)
        layer.cornerRadius = 10
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension SearchTextField:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("onur")
        if let searchText = textField.text{
            NewsAPI.sharedInstance.getNews(text: searchText) { [self] responseModel, error in
                guard let responseModel = responseModel else {
                    print("Error fetching news: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                NewsAPI.sharedInstance.articles = responseModel.articles // Haberleri aldık
                //print(NewsAPI.sharedInstance.articles)
               
                self.searchIconTapAction!()
            }
        }
        
    }
}
extension SearchTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rightPadding: CGFloat = 10 // Sağa kaydırma miktarı
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += rightPadding
        return rect
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}

