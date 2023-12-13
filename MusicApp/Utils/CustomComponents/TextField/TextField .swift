//
//  TextField .swift
//  MusicApp
//
//  Created by Enes Sancar on 1.12.2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private lazy var rightButton  = UIButton(type: .custom)
    private let authField: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authField = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor      = .secondarySystemBackground
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.systemGray4.cgColor
        textColor                 = .label
        tintColor                 = .label
        textAlignment             = .left
        layer.cornerRadius        = 8 
        
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        
        self.leftViewMode         = .always
        self.leftView             = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        switch fieldType {
        case .username:
            self.placeholder = "Username"
            
        case .email:
            self.placeholder = "Email address"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.placeholder = "Password"
            self.textContentType = .password
            self.isSecureTextEntry = true
            
            rightButton.setImage(UIImage(systemName: "eye.slash.fill") , for: .normal)
            rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
            rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
            rightButton.frame = CGRect(x:0, y:0, width:30, height:30)
            
            rightViewMode = .always
            rightView = rightButton
        }
    }
    
    @objc
    func toggleShowHide(button: UIButton) {
        toggle()
    }
    
    func toggle() {
        isSecureTextEntry.toggle()
        if isSecureTextEntry {
            rightButton.setImage(UIImage(systemName: "eye.slash.fill") , for: .normal)
        } else {
            rightButton.setImage(UIImage(systemName: "eye.fill") , for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
