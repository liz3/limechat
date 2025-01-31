// LimeChat is copyrighted free software by Satoshi Nakagawa <psychs AT limechat DOT net>.
// You can redistribute it and/or modify it under the terms of the GPL version 2 (see the file GPL.txt).

#import "FieldEditorTextView.h"


@implementation FieldEditorTextView
{
    KeyEventHandler* _keyHandler;
}

- (id)initWithFrame:(NSRect)frameRect textContainer:(NSTextContainer *)aTextContainer
{
    self = [super initWithFrame:frameRect textContainer:aTextContainer];
    if (self) {
        _keyHandler = [KeyEventHandler new];
    }
    return self;
}

-(bool)readSelection: (NSPasteboard*)board type: (NSPasteboardType)aType{
    NSLog(@"aaa");
    return true;
}
- (void)paste:(id)sender
{
    if (_pasteDelegate) {
        BOOL result = [_pasteDelegate fieldEditorTextViewPaste:self];
        if (result) {
            return;
        }
    }

    [super paste:sender];
}

- (void)setKeyHandlerTarget:(id)target
{
    [_keyHandler setTarget:target];
}

- (void)registerKeyHandler:(SEL)selector key:(int)code modifiers:(NSUInteger)mods
{
    [_keyHandler registerSelector:selector key:code modifiers:mods];
}

- (void)registerKeyHandler:(SEL)selector character:(UniChar)c modifiers:(NSUInteger)mods
{
    [_keyHandler registerSelector:selector character:c modifiers:mods];
}

- (void)keyDown:(NSEvent *)e
{
    if ([_keyHandler processKeyEvent:e]) {
        return;
    }

    [super keyDown:e];
}

@end
