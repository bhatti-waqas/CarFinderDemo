//
//  SIXTBaseViewModel.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/15/21.
//

import Foundation

public class SIXTViewModel {
    
    public weak var delegate : SIXTViewModelDelegate?
    private var ready:Bool = false
    private var loading:Bool = false
    
    public func load() {
        self.loading = true
    }
    
    public func load(with delegate: SIXTViewModelDelegate) {
        self.delegate = delegate
        self.load()
    }
    
    @discardableResult
    public func isReady(_ shouldNotifyDelegate: Bool = true)->Bool {
        if ready && shouldNotifyDelegate {
            self.makeReady()
        }
        return ready
    }

    public func isLoading() -> Bool {
        return loading
    }
    
    public func makeReady() {
        self.ready = true
        self.loading = false
        self.delegate?.onSIXTViewModelReady(self)
    }
    
    public func reset() {
        self.ready = false
        self.loading = false
        //self.delegate?.onSIXTViewModelNeedsUpdate(self)
    }
    
    public func throwError(with error: NetworkError) {
        //In some cases we are receving errors from background threads.
        //We need to make sure we use main thread since we are going to interact with UI
        Run.onMainThread {
            self.loading = false
            self.delegate?.onSIXTViewModelError(self, error: error)
        }
    }
}

public protocol SIXTViewModelDelegate: AnyObject {
    func onSIXTViewModelReady(_ viewModel: SIXTViewModel)
    func onSIXTViewModelError(_ viewModel:SIXTViewModel, error: NetworkError)
}

