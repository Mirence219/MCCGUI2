import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../elements"
import "../test"

Page {
    id: root
    background: null

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: includeServerListView

        function enter_server_content_page(index) {
            push(includeServerContent, { serverIndex : index + 1});
        }

        function exit_server_content_page() {
            pop();
        }

        function enter_test_page() {
            push(testIncludeServerContent);
        }
    }

    Component {
        id: includeServerListView

        IncludedServerListView {
            onClickServer: (index) => {
                if (index === 0) {
                    stackView.enter_test_page(index);
                    return;
                }
                stackView.enter_server_content_page(index);
            } 
        }
    }

    Component {
        id: includeServerContent

        IncludedServerContent {
            onClickBack: {
                stackView.exit_server_content_page();
            }
        }
    }

    Component {
        id: testIncludeServerContent

        TestIncludedServerContent {
            onClickBack: {
                stackView.exit_server_content_page();
            }
        }
    }
}
