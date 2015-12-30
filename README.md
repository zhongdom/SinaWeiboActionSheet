#新浪微博样式的ActionSheet
实现此功能的关键是在view里面生成一个UIWindow（该window会自动被加入到已有的window上面），然后设置windowlevel和hidden属性就可以让现实或者隐藏。

	//懒加载window，新建window之后会被自动添加到已有window上，只要设置windowLevel和hidden属性即可显示
	-(UIWindow *)actionWindow{
	
	    if (!_actionWindow) {
	        _actionWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
	        _actionWindow.windowLevel = UIWindowLevelAlert;
	        _actionWindow.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
	    }
	    return _actionWindow;
	}
	
	//显示
	-(void)show{
	    //设置self初始位置
	    self.frame = CGRectMake(0, ZDHEIGHT, ZDWIDTH, ZDHEIGHT);
	    
	    //添加本身到新建window
	    [self.actionWindow addSubview:self];
	    
	    self.actionWindow.hidden = NO;
	    [UIView animateWithDuration:ZDANIMATIONTIME animations:^{
	        self.frame = CGRectMake(0, 0, ZDWIDTH, ZDHEIGHT);
	    }];
	}
	
	-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
	    
	    [self dismissFromeSuperView];
	    
	}
	
	//移除
	-(void)dismissFromeSuperView {
	    
	    [UIView animateWithDuration:ZDANIMATIONTIME animations:^{
	        self.frame = CGRectMake(0, ZDHEIGHT, ZDWIDTH, ZDHEIGHT);
	        
	    } completion:^(BOOL finished) {
	        
	        [self removeFromSuperview];
	        self.actionWindow.hidden = YES;
	        self.actionWindow = nil;
	        
	    }];
	}


