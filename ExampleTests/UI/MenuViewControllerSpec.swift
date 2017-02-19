import Quick
import Nimble
@testable import SwipeToRevealExample

class MenuViewControllerSpec: QuickSpec {

    override func spec() {
        describe("MenuViewController") {
            var sut: MenuViewController!
            var assembly: Assembly!
            var viewModel: ViewModel!

            beforeEach {
                viewModel = ViewModel()
                assembly = Assembly(viewModel: viewModel)
                sut = MenuViewController(assembly: assembly)
            }

            context("load view") {
                beforeEach {
                    _ = sut.view
                }

                it("should have correct title") {
                    expect(sut.navigationItem.title).to(equal("Menu Title"))
                }

                describe("table view") {
                    it("should have 1 section") {
                        expect(sut.numberOfSections(in: sut.tableView)).to(equal(1))
                    }

                    it("should have 3 rows") {
                        expect(sut.tableView(sut.tableView, numberOfRowsInSection: 0)).to(equal(3))
                    }

                    func testCell(_ row: Int) {
                        describe("cell \(row + 1)") {
                            var cell: UITableViewCell!

                            beforeEach {
                                cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: row, section: 0))
                            }

                            it("should have correct title") {
                                expect(cell.textLabel?.text).to(equal(viewModel.items[row].title))
                            }

                            it("should have correct accessory type") {
                                expect(cell.accessoryType).to(equal(UITableViewCellAccessoryType.disclosureIndicator))
                            }
                        }
                    }

                    testCell(0)
                    testCell(1)
                    testCell(2)
                }
            }
        }
    }

    struct Assembly: MenuAssembly {
        let viewModel: MenuViewModel
    }

    struct ViewModel: MenuViewModel {
        let title = "Menu Title"
        let items: [MenuItemViewModel] = [
            ItemViewModel(title: "Menu Item 1"),
            ItemViewModel(title: "Menu Item 2"),
            ItemViewModel(title: "Menu Item 3")
        ]
    }

    struct ItemViewModel: MenuItemViewModel {
        let title: String
    }

}